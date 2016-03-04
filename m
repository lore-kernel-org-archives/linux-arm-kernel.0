From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 4 Mar 2016 08:27:26 +0100
Subject: [linux-sunxi] Re: [PATCH v4 1/2] ehci-platform: Add support for
 controllers with multiple reset lines
In-Reply-To: <20160304043559.GA21743@kroah.com>
References: <1456592339-31767-1-git-send-email-hdegoede@redhat.com>
 <1456592339-31767-2-git-send-email-hdegoede@redhat.com>
 <20160304043559.GA21743@kroah.com>
Message-ID: <56D938DE.10409@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 04-03-16 05:35, Greg Kroah-Hartman wrote:
> On Sat, Feb 27, 2016 at 05:58:58PM +0100, Hans de Goede wrote:
>> From: Reinder de Haan <patchesrdh@mveas.com>
>>
>> At least the EHCI/OHCI found on the Allwinnner H3 SoC needs multiple
>> reset lines, the controller will not initialize while the reset for
>> its companion is still asserted, which means we need to de-assert
>> 2 resets for the controller to work.
>>
>> Signed-off-by: Reinder de Haan <patchesrdh@mveas.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> Acked-by: Alan Stern <stern@rowland.harvard.edu>
>> Acked-by: Rob Herring <robh@kernel.org>
>> ---
>> Changes in v2:
>> -Use the new reset_control_[de]assert_shared reset-controller functions
>> Changes in v3:
>> -Adjust for changes to shared-reset reset-controller functions
>> Changes in v4:
>> -Fix Ugly continuation line
>
> This breaks the build horribly :(
>
> As does patch 2/2, ugh.

As said in the cover letter:

"These patches apply on top of the related
reset-controller patches which have just been merged here:

git://git.pengutronix.de/git/pza/linux.git reset/next"

I guess I should have done s/apply on top of/depend on/
in the above bit. These patches apply fine without those
changes, but indeed they will not build.

You may want to ask Philipp Zabel (added to the To: list)
to create a topic branch for this which you can merge into
your tree.

Regards,

Hans
