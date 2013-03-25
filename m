From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 25 Mar 2013 14:03:20 +0100
Subject: [PATCH] ARM: dove: add more hardware description in the DT
In-Reply-To: <20130325134222.56fe44fc@armhf>
References: <20130325103159.0c1b4f17@armhf>
 <CABJ1b_RrFpKdH3w=v4gvRQ-8UniKOz9o9VVJ8Q=AQz5WaN0NRQ@mail.gmail.com>
 <20130325134222.56fe44fc@armhf>
Message-ID: <CABJ1b_Tdi4RrBPpNS_xUBQ77rQ_G74vCBNLpgwOv_DXoBWGong@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Also added Russell to the discussion, as I am sure he wants to comment
on dove drm driver ;)

On Mon, Mar 25, 2013 at 1:42 PM, Jean-Francois Moine <moinejf@free.fr> wrote:
> On Mon, 25 Mar 2013 11:21:13 +0100
> Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:
>> On Mon, Mar 25, 2013 at 10:31 AM, Jean-Francois Moine <moinejf@free.fr> wrote:
>> Besides lcd and i2s there is also
>>
>> dcon: display-controller at 830000 and
>> ire: image-rotation-engine at 831000
>>
>> I am not yet 100% sure how to hook them up in dove-drm that I am
>> writing on but I want to have them in somehow. DCON will allow to
>> mux lcd0/lcd1 data streams, i.e. clone or pan lcd0 to lcd1. IRE allows
>> to rotate the memory buffer loaded by -90/90deg.
>
> My first aim is to have the dove-drm in the mainline. These devices
> could be added later, as the ac'97, gpu and vpu. Also, rotating the
> image is not very useful when your monitor cannot rotate! (I wonder if
> such monitors still exist as the one I used on a MAC in the 80's)

I guess you let the user choose to have it rotated or not.

> But, anyway, I may do it. The only problem is that dcon and ire are
> sharing the same irq. How should I declare that?

Then just have one node

dcon: display-controller at 830000 {
   compatible = "marvell,dove-dcon";
   reg = <0x830000 0xc4>, <0x831000 0x8c>;
   interrupts = <45>;
};

We can detect if ire is available on the second reg property.

> BTW, I am ready to upload a new version of the dove-drm on my site. It
> now uses the dt for getting the hdmi encoder. Do you prefer I or you do
> the merge?

>From the current status of either yours or mine driver none of it is ready
for mainline. You can of course have your own repo and provide a version
there. As soon as we are both happy with one of the drivers, we can send
a patch here.

Sebastian
