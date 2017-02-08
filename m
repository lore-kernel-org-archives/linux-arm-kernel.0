From: mzoran@crowfest.net (Michael Zoran)
Date: Tue, 07 Feb 2017 17:43:11 -0800
Subject: [PATCH] staging: vc04_services: remove unused functions
In-Reply-To: <20170207221954.GE11154@mwanda>
References: <20170207115308.5208-1-alexander@alemayhu.com>
 <20170207120943.GC11154@mwanda> <87lgthpuv5.fsf@eliezer.anholt.net>
 <20170207221954.GE11154@mwanda>
Message-ID: <1486518191.2883.2.camel@crowfest.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-02-08 at 01:19 +0300, Dan Carpenter wrote:
> On Tue, Feb 07, 2017 at 01:13:34PM -0800, Eric Anholt wrote:
> > Dan Carpenter <dan.carpenter@oracle.com> writes:
> > 
> > > There is a bunch of vc04_services that we're still looking to
> > > merge in
> > > the near future.??Please hold off deleting these until we are
> > > further
> > > along on that.
> > 
> > Checking the downstream tree, these are actually dead.
> 
> Ahh...??Thanks.??In that case, of course, fine let's remove them.
> 
> regards,
> dan carpenter
> 

I made a table awhile ago as to which entry points are being used by
what.  Most of the entry points are indeed only being used by those
other drivers which exist mostly to support a debugging tool called
vcdbg(which I didn't find that useful).

The other drivers are small drivers, but I'm not sure bringing them
here makes much sense either especially since they are mostly to
support that debugging tool.  Which complicates things because probably
half the driver could be otherwise deleted instantly.

I attached a list of driver exports and which drivers are using them.



-------------- next part --------------
interface/vchiq_arm/vchiq_connected.c:EXPORT_SYMBOL(vchiq_add_connected_callback)   -- 	Github(vc_cma/vc_cma.c & vc_sm/vmcs_sm.c)
interface/vchiq_arm/vchiq_kern_lib.c:EXPORT_SYMBOL(vchiq_initialise)		    --  Github(vc_cma/vc_cma.c)
interface/vchiq_arm/vchiq_kern_lib.c:EXPORT_SYMBOL(vchiq_shutdown)		    --  Github(vc_cma/vc_cma.c)
interface/vchiq_arm/vchiq_kern_lib.c:EXPORT_SYMBOL(vchiq_connect)		    --  Github(vc_cma/vc_cma.c)
interface/vchiq_arm/vchiq_kern_lib.c:EXPORT_SYMBOL(vchiq_add_service)		    --  Internal Only
interface/vchiq_arm/vchiq_kern_lib.c:EXPORT_SYMBOL(vchiq_open_service)		    --  Github(vc_cma/vc_cma.c)
interface/vchiq_arm/vchiq_kern_lib.c:EXPORT_SYMBOL(vchiq_queue_bulk_transmit)	    --  Internal Only
interface/vchiq_arm/vchiq_kern_lib.c:EXPORT_SYMBOL(vchiq_queue_bulk_receive)	    --  Internal Only
interface/vchiq_arm/vchiq_kern_lib.c:EXPORT_SYMBOL(vchiq_bulk_transmit)		    --  Internal Only
interface/vchiq_arm/vchiq_kern_lib.c:EXPORT_SYMBOL(vchiq_bulk_receive)		    --  Internal Only
interface/vchiq_arm/vchiq_shim.c:EXPORT_SYMBOL(vchi_msg_peek)			    --  Github(vc_sm/vc_vchi_sm.c)
interface/vchiq_arm/vchiq_shim.c:EXPORT_SYMBOL(vchi_msg_remove)			    --  Github(vc_sm/vc_vchi_sm.c)
interface/vchiq_arm/vchiq_shim.c:EXPORT_SYMBOL(vchi_msg_queue)			    --  bcm2835/mmal-vchiq.c, bcm2835-audio/bcm2835-vchiq.c, Github(vc_sm/vc_vchi_sm.c)
interface/vchiq_arm/vchiq_shim.c:EXPORT_SYMBOL(vchi_bulk_queue_receive)		    --  bcm2835/mmal-vchiq.c
interface/vchiq_arm/vchiq_shim.c:EXPORT_SYMBOL(vchi_bulk_queue_transmit)	    --  bcm2835-audio/bcm2835-vchiq.c
interface/vchiq_arm/vchiq_shim.c:EXPORT_SYMBOL(vchi_msg_dequeue)		    --  bcm2835-audio/bcm2835-vchiq.c
interface/vchiq_arm/vchiq_shim.c:EXPORT_SYMBOL(vchi_held_msg_release) 		    --  bcm2835/mmal-vchiq.c
interface/vchiq_arm/vchiq_shim.c:EXPORT_SYMBOL(vchi_msg_hold)			    --  bcm2835/mmal-vchiq.c
interface/vchiq_arm/vchiq_shim.c:EXPORT_SYMBOL(vchi_initialise)			    --  bcm2835/mmal-vchiq.c, bcm2835-audio/bcm2835-vchiq.c, Github(vc_sm/vmcs_sm.c)
interface/vchiq_arm/vchiq_shim.c:EXPORT_SYMBOL(vchi_connect)			    --  bcm2835/mmal-vchiq.c, Github(vc_sm/vmcs_sm.c)
interface/vchiq_arm/vchiq_shim.c:EXPORT_SYMBOL(vchi_disconnect) 		    --  Internal Only
interface/vchiq_arm/vchiq_shim.c:EXPORT_SYMBOL(vchi_service_open)		    --  bcm2835/mmal-vchiq.c, Github(vc_sm/vc_vchi_sm.c)
interface/vchiq_arm/vchiq_shim.c:EXPORT_SYMBOL(vchi_service_create)		    --  Internal Only
interface/vchiq_arm/vchiq_shim.c:EXPORT_SYMBOL(vchi_service_close)		    --  Github(vc_sm/vc_vchi_sm.c)
interface/vchiq_arm/vchiq_shim.c:EXPORT_SYMBOL(vchi_service_destroy)                --  Internal Only
interface/vchiq_arm/vchiq_shim.c:EXPORT_SYMBOL(vchi_service_set_option)		    --  Internal Only
interface/vchiq_arm/vchiq_shim.c:EXPORT_SYMBOL(vchi_get_peer_version)		    --  bcm2835-audio/bcm2835-vchiq.c
interface/vchiq_arm/vchiq_shim.c:EXPORT_SYMBOL(vchi_service_use)		    --  bcm2835/mmal-vchiq.c, bcm2835-audio/bcm2835-vchiq.c, Github(vc_sm/vc_vchi_sm.c)
interface/vchiq_arm/vchiq_shim.c:EXPORT_SYMBOL(vchi_service_release)		    --  bcm2835/mmal-vchiq.c, bcm2835-audio/bcm2835-vchiq.c
