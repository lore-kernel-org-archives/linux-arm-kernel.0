From: robherring2@gmail.com (Rob Herring)
Date: Thu, 8 Jan 2015 15:38:13 -0600
Subject: [PATCH 0/9] ARM Versatile multi-platform support
In-Reply-To: <CACRpkda8T8CwghVYtTw41h_y+GdCA5xCEaSL1Jy4VZBo3MAy-Q@mail.gmail.com>
References: <1419967718-26909-1-git-send-email-robherring2@gmail.com>
 <CACRpkda8T8CwghVYtTw41h_y+GdCA5xCEaSL1Jy4VZBo3MAy-Q@mail.gmail.com>
Message-ID: <CAL_JsqKLNPVDCUELaZU8JW0roT3RcyqcxtJbvbYQrjzxjt3FeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 8, 2015 at 1:47 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Dec 30, 2014 at 8:28 PM, Rob Herring <robherring2@gmail.com> wrote:
>
>> From: Rob Herring <robh@kernel.org>
>>
>> This series converts ARM Versatile platform to multi-platform. I started
>> this some time ago and some pieces were already merged. The primary
>> piece remaining is converting the PCI host to DT which I was waiting for
>> the common PCI DT parsing to get settled. Now that that is in place as
>> well as a few other pieces are in place like multi-platform fixes for
>> CLCD, we can fully convert Versatile to DT and multi-platform.
>>
>> There's still a few things that need DT support which can be done
>> later:
>> - MMC card detect and write protect. Should be able to use VExpress
>>   support
>> - Reboot support. Should be able to re-use Realview reboot code.
>> - flash phys-map support. Binding exists, but specifically Vpp control
>>   is needed.
>> - CLCD support. Not sure where this is at.
>
> I like it overall but would like to see some use of the syscon
> pattern to access random registers in syscon, and specifically not
> to refer to these registers as some "gpio" because they aren't.

I'm not sure I follow. Creating GPIO lines for SD card detect and
write protect is exactly how VExpress syscon was implemented.

Rob
