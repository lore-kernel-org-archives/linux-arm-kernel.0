From: b-liu@ti.com (Bin Liu)
Date: Fri, 23 Sep 2016 08:47:56 -0500
Subject: [PATCH v2 2/3] musb: sunxi: Remove custom babble handling
In-Reply-To: <db52a0d4-74f1-4f47-eb67-bcfbd66f174f@redhat.com>
References: <20160922111901.15337-1-hdegoede@redhat.com>
 <20160922111901.15337-2-hdegoede@redhat.com>
 <20160922135415.GB31827@uda0271908>
 <39199bd7-a372-0312-6177-5b0fc2d683ac@redhat.com>
 <20160922143050.GC31827@uda0271908>
 <db52a0d4-74f1-4f47-eb67-bcfbd66f174f@redhat.com>
Message-ID: <20160923134756.GE31827@uda0271908>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 23, 2016 at 04:42:26PM +0300, Hans de Goede wrote:
> Hi,
> 
> On 09/22/2016 05:30 PM, Bin Liu wrote:
> >Hi,
> >
> >On Thu, Sep 22, 2016 at 05:03:39PM +0300, Hans de Goede wrote:
> >>Hi,
> >>
> >>On 09/22/2016 04:54 PM, Bin Liu wrote:
> >>>Hi,
> >>>
> >>>On Thu, Sep 22, 2016 at 02:19:00PM +0300, Hans de Goede wrote:
> >>>>The musb-core now a days always treats babble errors in host mode
> >>>
> >>>I don't think this statement is accurate. You might want to change it to
> >>>"The musb core already handles babble interrupt" or something else.
> >>
> >>It is accurate if you look in the history at drivers/usb/musb
> >>commits around 15-03-10 you will see 2 relevant commits:
> >>
> >>https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/usb/musb?id=b4dc38fd45b63e3da2bc98db5d283a15a637a2fa
> >>
> >>"usb: musb: core: simplify musb_recover_work()"
> >>
> >>This commits introduces calling musb_root_disconnect(musb)
> >>on babble errors, that was not happening before which is why
> >
> >That is true, but calling musb_root_disconnect() is just one step of the
> >recovery in musb core, not all.
> >
> >The statement of "treats babble errors in host mode as disconnects"
> >implies all the babble handling is just disconnect, which is not
> >accurate.
> 
> Ok, I'll send out a v3 with an improved commit msg.

Thanks.

If Kishon gives his Acked-by, I will take all the 3 patches. Or
I can just take the 2 musb patches into my tree.

Regards,
-Bin.
