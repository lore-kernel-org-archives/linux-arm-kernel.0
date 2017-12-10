From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 10 Dec 2017 19:03:13 +0100
Subject: [PATCH] nvmem: meson-mx-efuse: fix reading from an offset other
 than 0
In-Reply-To: <CAFBinCBRs-enwX_-uRBOo0dXYPY3q0keD_-RZ_G=ZgsqhM1ARQ@mail.gmail.com>
References: <20171112183412.12806-1-martin.blumenstingl@googlemail.com>
 <CAFBinCBRs-enwX_-uRBOo0dXYPY3q0keD_-RZ_G=ZgsqhM1ARQ@mail.gmail.com>
Message-ID: <CAFBinCCNSJ=CRGUzcZ2Jh-Rh1AO3O9i=ApNYdJWH0zDA=ohn=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Srinivas, Hi Greg,

On Fri, Dec 1, 2017 at 10:24 PM, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
> Hi Srinivas, Hi Greg,
>
> On Sun, Nov 12, 2017 at 7:34 PM, Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
>> meson_mx_efuse_read calculates the address internal to the eFuse based
>> on the offset and the word size. This works fine with any given offset.
>> However, the offset is also included when writing to the output buffer.
>> This means that reading 4 bytes at offset 500 tries to write beyond the
>> array allocated by the nvmem core as it wants to write the 4 bytes to
>> "buffer address + offset (500)".
>> This issue did not show up in the previous tests since no driver uses
>> any value from the eFuse yet and reading the eFuse via sysfs simply
>> reads the whole eFuse, starting at offset 0.
>>
>> Fix this by only including the offset in the internal address
>> calculation.
>>
>> Fixes: 8caef1fa9176 ("nvmem: add a driver for the Amlogic Meson6/Meson8/Meson8b SoCs")
> if you don't have any comments on this patch: could you please queue
> it as a fix for 4.15 (which is where above commit landed)?
(gentle ping) do you have any comments for this patch?


Regards
Martin
