From: balbi@ti.com (Felipe Balbi)
Date: Fri, 2 Jan 2015 14:33:20 -0600
Subject: [PATCH 2/3] soc: ti: Add wkup_m3_ipc driver
In-Reply-To: <20150102201643.GE4920@saruman>
References: <1420228817-41310-1-git-send-email-d-gerlach@ti.com>
 <1420228817-41310-3-git-send-email-d-gerlach@ti.com>
 <20150102201643.GE4920@saruman>
Message-ID: <20150102203320.GF4920@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 02, 2015 at 02:16:43PM -0600, Felipe Balbi wrote:
> On Fri, Jan 02, 2015 at 02:00:16PM -0600, Dave Gerlach wrote:
> > Introduce a wkup_m3_ipc driver to handle communication between the MPU
> > and Cortex M3 wkup_m3 present on am335x.
> > 
> > This driver is responsible for actually booting the wkup_m3_rproc and
> > also handling all IPC which is done using the IPC registers in the control
> > module, a mailbox, and a separate interrupt back from the wkup_m3. A small
> > API is exposed for executing specific power commands, which include
> > configuring for low power mode, request a transition to a low power mode,
> > and status info on a previous transition.

another comment is that no user of such API is provided, so it's very
difficult to verify that there's no other way of implementing this.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150102/66fab74c/attachment.sig>
