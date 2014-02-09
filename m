From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 09 Feb 2014 14:29:14 +0100
Subject: [linux-sunxi] [PATCH v2] ARM: sunxi: Add driver for sunxi usb phy
In-Reply-To: <CAGb2v67L1X63Pp10H6MFApkLzCvwOokxSW+fH6KquDnqaRGRmQ@mail.gmail.com>
References: <1391790801-27864-1-git-send-email-hdegoede@redhat.com>
 <CAGb2v67L1X63Pp10H6MFApkLzCvwOokxSW+fH6KquDnqaRGRmQ@mail.gmail.com>
Message-ID: <52F782AA.5010207@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02/08/2014 05:32 AM, Chen-Yu Tsai wrote:
> On Sat, Feb 8, 2014 at 12:33 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> The Allwinner A1x / A2x SoCs have 2 or 3 usb phys which are all accessed
>> through a single set of registers. Besides this there are also some other
>> phy related bits which need poking, which are per phy, but shared between the
>> ohci and ehci controllers, so these are also controlled from this new phy
>> driver.
>>

<snip>

>> +               snprintf(name, sizeof(name), "usb%d_reset", i);
>> +               reset = devm_reset_control_get(dev, name);
>> +               if (IS_ERR(phy)) {
>> +                       dev_err(dev, "failed to get reset %s\n", name);
>> +                       return PTR_ERR(phy);
>> +               }
>
> Wrong variable checked for error here that I pointed out before is still wrong.

Ah, yes my bad, I'll do a v3 fixing this, and switching to using register names as
Maxime requested. Don't know whether I'll be able to send v3 today as I'm currently
on the road. If not I'll try to get it out the door tomorrow.

Regards,

Hans
