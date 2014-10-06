From: balbi@ti.com (Felipe Balbi)
Date: Mon, 6 Oct 2014 09:33:38 -0500
Subject: CPSW bug with AM437x SK
In-Reply-To: <543266F3.4090200@ti.com>
References: <20141003010418.GA9612@saruman>
 <543266F3.4090200@ti.com>
Message-ID: <20141006143338.GC12392@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Oct 06, 2014 at 03:24:59PM +0530, Mugunthan V N wrote:
> On Friday 03 October 2014 06:34 AM, Felipe Balbi wrote:
> > [  261.177168] [<c0648d48>] (skb_panic) from [<c0565edc>] (skb_put+0x5c/0x60)
> > [  261.184415] [<c0565edc>] (skb_put) from [<c0605aac>] (unix_stream_sendmsg+0x164/0x390)
> > [  261.192712] [<c0605aac>] (unix_stream_sendmsg) from [<c055b364>] (sock_aio_write+0xdc/0xfc)
> > [  261.201475] [<c055b364>] (sock_aio_write) from [<c014c42c>] (do_sync_write+0x8c/0xb4)
> > [  261.209697] [<c014c42c>] (do_sync_write) from [<c014cf70>] (vfs_write+0x118/0x1c0)
> > [  261.217652] [<c014cf70>] (vfs_write) from [<c014d564>] (SyS_write+0x4c/0xa0)
> > [  261.225054] [<c014d564>] (SyS_write) from [<c000ed40>] (ret_fast_syscall+0x0/0x48)
> > [  261.232988] Code: e58d4008 e58de00c e59f0008 ebfff48e (e7f001f2) 
> > [  261.239378] ---[ end trace d64258d586f40104 ]---
> 
> The BT shows that the warn came from a unix socket interface, so this
> cannot be a CPSW bug, its a bug in unix socket.
> 
> Are you not seeing this issue with file system in any other media?

Have not tried with other media, but since it comes from vfs_write() and
my rootfs sits in NFS I figured "that might be the cause". Could not
reproduce this with BeagleBone Black, btw.

> I will try to reproduce this locally with my AM437x EVMsk.

alright.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141006/1f16b78c/attachment.sig>
