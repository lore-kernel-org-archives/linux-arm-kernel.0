From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 8 Jan 2018 10:27:44 +0100
Subject: [PATCH] Revert "ARM: dts: bcm283x: Fix DTC warnings about missing
 phy-cells"
In-Reply-To: <df3db2e7-5d0f-9c1c-b005-41cf00e7d851@i2se.com>
References: <1515332212-23593-1-git-send-email-stefan.wahren@i2se.com>
 <87incdjp9k.fsf@anholt.net> <df3db2e7-5d0f-9c1c-b005-41cf00e7d851@i2se.com>
Message-ID: <CAK8P3a3qfiX_ZsD8pLmoTJZ2+Q8PkHGmfTFW=NL8P8QFML_dLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 8, 2018 at 10:15 AM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> Hi Eric,
> Am 07.01.2018 um 23:08 schrieb Eric Anholt:
>>
>> Stefan Wahren <stefan.wahren@i2se.com> writes:
>>
>>> This reverts commit 014d6da6cb2525d7f48fb08c705cb130cc7b5f4a.
>>>
>>> The DT clean up could trigger an endless deferred probe of DWC2 USB
>>> driver
>>> on the Raspberry Pi 2/3. So revert the change until we fixed the probing
>>> issue.
>>
>> Why's that?  I found that I needed to enable the generic no-op phy
>> driver, but other than that it was fine.
>
>
> in order to avoid this regression. Changing the configuration is not a
> solution for the kernelci guys.
>
> Btw
>
> CONFIG_NOP_USB_XCEIV=y
>
> is already enabled in arm64/defconfig and the issue still occured. Do you
> mean a different option?

Obviously we need to fix this, but I really want to understand what exactly
happened so we can fix the code if possible rather than making the
dts file incompatible with the binding again.

Do you have any more insight into how we get into the deferred probe
situation?

       Arnd
