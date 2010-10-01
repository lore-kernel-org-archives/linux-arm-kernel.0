From: fernando.lugo@ti.com (Guzman Lugo, Fernando)
Date: Fri, 1 Oct 2010 13:54:37 -0500
Subject: [PATCH] scatterlist: define SG chain for arm architecture
In-Reply-To: <20101001163958.GA22533@n2100.arm.linux.org.uk>
References: <1285950521-8093-1-git-send-email-x0095840@ti.com>
	<20101001163958.GA22533@n2100.arm.linux.org.uk>
Message-ID: <496565EC904933469F292DDA3F1663E602F46545F2@dlee06.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk] 
> Sent: Friday, October 01, 2010 11:40 AM
> To: Guzman Lugo, Fernando
> Cc: linux-arm-kernel at lists.infradead.org; 
> Hiroshi.DOYU at nokia.com; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH] scatterlist: define SG chain for arm architecture
> 
> On Fri, Oct 01, 2010 at 11:28:41AM -0500, Fernando Guzman Lugo wrote:
> > Define SG chain for ARM architecture in order to work with big 
> > buffers. This patch is needed in order to iovmm users can 
> pass a big 
> > buffer to map it and ARM architecture has not issues using SG chain.
> > 
> > This change was suggested by FUJITA Tomonori.
> 
> Have you audited all places where SG lists are used in the 
> ARM architecture to ensure that SG chain support is safe?  
> (That goes for ARM generic code and ARM specific drivers.)

Unfortunately I only can test on omap platform. I am not so
Familiar with scatter gather code and what is the restriction
For one page size of SG list (maybe they can comment). However
For SG chaining seems there is no restriction with the exception
Of using the with function to assigned to page and iterate each
Element of the list and it has sometime when SG chaining was 
Introduce all the code should be use this new functions.

I am agree with you about make sure nothing is broken with the change.
Maybe some people of other arm platforms can comment if they have
Issues with the patch and test the change and if there is no complain
Then merge the change. If there are issues maybe I can send the patch
Just for omap platform. However, looks like there is no issues enabling
It to all arm, but again I am not so familiar with SG, so I will let
The experts to comment.

Thanks a lot,
Fernando.




> 
> If the answer is no, this patch is unacceptable until such a 
> review has been carried out.
> 
