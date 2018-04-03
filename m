From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 3 Apr 2018 20:05:53 +0200
Subject: [PATCH v6 0/3] add support for Socionext SynQuacer I2C controller
In-Reply-To: <20180403150139.l7oec4doafmsidfp@ninjato>
References: <20180325110747.8852-1-ard.biesheuvel@linaro.org>
 <20180403150139.l7oec4doafmsidfp@ninjato>
Message-ID: <CAKv+Gu9cqQqq_etTSvdBp4Jjk5O_0FePe74phDqt5EO6Cm-_vQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 April 2018 at 17:01, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> - switch to generic recovery using minimal helpers to drive the SDA/SCL lines
>>   directly
>
> If you had added this incrementally, reviewing would have been easier (=
> faster). The callbacks look okay...
>
>> - don't recover on every error
>
> ... but you are now never recovering. You don't call i2c_recover_bus().
>

Yeah, good point. So when exactly should this be called? Only on error
conditions that could be caused by a misbehaving slave?

>> - add patch to sanity check i2c_transfer() arguments in core code (#3)
>
> See small comment there.
>
