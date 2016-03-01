From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Tue, 1 Mar 2016 16:18:45 +0100
Subject: [PATCH 3/8] ARM64: dts: Prepare configs for Amlogic Meson GXBaby
In-Reply-To: <56D5AA87.7020401@arm.com>
References: <1456789465-2962-1-git-send-email-afaerber@suse.de>
 <1456789465-2962-4-git-send-email-afaerber@suse.de>
 <56D5AA87.7020401@arm.com>
Message-ID: <56D5B2D5.9010405@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 01.03.2016 um 15:43 schrieb Sudeep Holla:
> On 29/02/16 23:44, Andreas F?rber wrote:
>> +    psci {
>> +        compatible = "arm,psci";
> 
> Any particular reason why PSCI v0.2 or above is not supported on this
> platform. PSCI v0.1 is very old now and I assume this platform is
> relatively new.

I am not affiliated with Amlogic or Tronsmart, so I cannot answer why.

>> +        method = "smc";
>> +        cpu_suspend = <0xc4000001>;
>> +        cpu_off = <0x84000002>;
>> +        cpu_on = <0xc4000003>;
>> +        migrate = <0xc4000005>;
> 
> Atleast the functions ids look like v0.2 or above. So check if it's
> actually v0.2 or above

If you let me know how! Just change the compatible string to -0.2 and
wait for some big boom or watch out for any misbehavior in particular?
Are there any memory locations to check the version or something visible
in U-Boot source code indicating it?

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton; HRB 21284 (AG N?rnberg)
