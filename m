From: stefan@agner.ch (Stefan Agner)
Date: Wed, 17 Feb 2016 13:52:07 -0800
Subject: [PATCH v2 2/3] ARM: dts: vf-colibri: add basic supply regulators
In-Reply-To: <CAOMZO5Bb1eGSinoNkUhB_2w8mWdA+RQA0Z4geJp8B-MfGryAHw@mail.gmail.com>
References: <1455668317-15728-1-git-send-email-stefan@agner.ch>
 <1455668317-15728-2-git-send-email-stefan@agner.ch>
 <CAOMZO5Bb1eGSinoNkUhB_2w8mWdA+RQA0Z4geJp8B-MfGryAHw@mail.gmail.com>
Message-ID: <a07b405a5c73b092eaa6422b8562b56f@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-02-16 16:28, Fabio Estevam wrote:
> On Tue, Feb 16, 2016 at 10:18 PM, Stefan Agner <stefan@agner.ch> wrote:
> 
>> +       reg_module_3v3: regulator-module-3v3 {
>> +               compatible = "regulator-fixed";
>> +               regulator-name = "+V3.3";
>> +               regulator-min-microvolt = <3300000>;
>> +               regulator-max-microvolt = <3300000>;
>> +               regulator-always-on;
> 
> This 'regulator-always-on' property can be removed.
> 
>> +       };
>> +
>> +       reg_module_3v3_avdd: regulator-module-3v3-avdd {
>> +               compatible = "regulator-fixed";
>> +               regulator-name = "+V3.3_AVDD_AUDIO";
>> +               regulator-min-microvolt = <3300000>;
>> +               regulator-max-microvolt = <3300000>;
>> +               regulator-always-on;
> 
> Same here.

Hm, should I remove them also in Patch 1/3? It's a fixed regulator too,
hence I guess regulator-always-on is pointless there too...?

--
Stefan
