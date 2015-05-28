From: sre@kernel.org (Sebastian Reichel)
Date: Thu, 28 May 2015 19:38:29 +0200
Subject: [PATCH V2 3/6] power: mxs_power: add driver for mxs power
 subsystem
In-Reply-To: <5565F1F9.2010801@i2se.com>
References: <1430346747-28728-1-git-send-email-stefan.wahren@i2se.com>
 <1430346747-28728-4-git-send-email-stefan.wahren@i2se.com>
 <20150523174149.GA16004@earth> <55656E70.6030906@i2se.com>
 <20150527135150.GA9205@earth> <5565F1F9.2010801@i2se.com>
Message-ID: <20150528173828.GA31619@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, May 27, 2015 at 06:34:01PM +0200, Stefan Wahren wrote:
> the driver consists of multiple files in the mxs sub directory.
> I linked to the main file to reduce search effort. The battery
> handling incl. charging should be implemented in ddi_power_battery.c
>
> From my understanding it's not possible to determine where the 5V
> exactly come from (either 5V wall plug or USB). The driver simply uses
> the USB PHY state.

Yes, but your driver does not even check, that there is 5V. It even
reports AC online if neither USB nor wall charger is connected.

> > While you can skip implementation of battery connection check
> > you should make sure, that AC is actually connected.
> 
> Do you refer to the right state of property
> POWER_SUPPLY_PROP_ONLINE or driver probing?

I'm referring to the right state.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150528/0c12a62a/attachment.sig>
