From: mkl0301@hotmail.com (mkl lin)
Date: Fri, 11 Dec 2009 12:32:06 +0000
Subject: dma_cache_maint_contiguous should be patched asdma_cache_maint do
In-Reply-To: <1260524165.3109.3.camel@pc1117.cambridge.arm.com>
References: <SNT109-W5125384E245D2B1026CD6DA78D0@phx.gbl>,
	<1260524165.3109.3.camel@pc1117.cambridge.arm.com>
Message-ID: <SNT109-W606545835EAEDC6CE7A542A78C0@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>> BTW, read performance drops from 64MBps to 44MBps on my platform.
> Is this compared to the IPI patch or to the UP (maxcpus=1) version?
> You can try placing a "pld [r0, #32] before the new ldr/str so that it
> fetches the next cache line while the loop is dealing with the current
> one.

I have redo all the tests again.

Linux 2.6.31.1
pcie sata adapter,?ahci.c
read 1GB file

1CPU:13.56/13.56/13.60 (sec) ~ 75.5MBps
SMP+IPI:16.29/16.14/16.05 (sec) ~ 63.8MBps
SMP+RFO/WFO:21.71/21.72/21.70 (sec) ~ 47.18MBps
SMP+RFO/WFO/pld:21.63/21.46/21.41 (sec) ~ 47.82MBps

Best Regards,
Mac Lin.
 		 	   		  
_________________________________________________________________
Windows Live: Make it easier for your friends to see what you?re up to on Facebook.
http://www.microsoft.com/middleeast/windows/windowslive/see-it-in-action/social-network-basics.aspx?ocid=PID23461::T:WLMTAGL:ON:WL:en-xm:SI_SB_2:092009
