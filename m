From: sean.wang@mediatek.com (Sean Wang)
Date: Wed, 23 May 2018 14:37:03 +0800
Subject: [SPAM]Re: [PATCH v2 4/7] Bluetooth: Add new quirk for
 non-persistent setup settings
In-Reply-To: <1526976323.18877.47.camel@mtkswgap22>
References: <cover.1526374087.git.sean.wang@mediatek.com>
 <1d6097f538b3182b2876ad48225ecd6e2d1b128c.1526374087.git.sean.wang@mediatek.com>
 <920B3BE9-3FE8-4AC6-8C5F-63B0E00182AC@holtmann.org>
 <1526976323.18877.47.camel@mtkswgap22>
Message-ID: <1527057423.4607.3.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-05-22 at 16:05 +0800, Sean Wang wrote:
> On Tue, 2018-05-22 at 09:21 +0200, Marcel Holtmann wrote:
> > Hi Sean,
> > 
> 
> [ ... ]
> 
> > > -	if (hci_dev_test_flag(hdev, HCI_SETUP)) {
> > > +	if (hci_dev_test_flag(hdev, HCI_SETUP) ||
> > > +	    test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {
> > > 		hci_sock_dev_event(hdev, HCI_DEV_SETUP);
> > 
> > I am not 100% sure that we want to send the HCI_DEV_SETUP event also multiple times. That is a userspace change that I would need to think about. We need to check create_monitor_event() and see what the btmon trace for this looks like. Can you send me a btmon -w trace.log when this change is active.
> > 
> > Regards
> > 
> > Marcel
> > 
> 
> Sure, I'll send you the trace.log with the change is active.
> 
> 	Sean
> 

Hi, Marcel

Attached trace.log was captured when I inputted commands power on and
then off in bluetoothctl.

	Sean 

> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

-------------- next part --------------
A non-text attachment was scrubbed...
Name: trace.log
Type: text/x-log
Size: 6573 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180523/db18fea4/attachment.bin>
