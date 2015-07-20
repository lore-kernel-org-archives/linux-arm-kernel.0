From: julien.grall@citrix.com (Julien Grall)
Date: Mon, 20 Jul 2015 18:54:56 +0100
Subject: [Xen-devel] [PATCH v2 00/20] xen/arm64: Add support for 64KB page
In-Reply-To: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
References: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
Message-ID: <55AD35F0.3090706@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/07/15 21:42, Julien Grall wrote:
> Average betwen 10 iperf :
> 
> DOM0	    Guest       Result
> 
> 4KB-mod	    64KB        3.176 Gbits/sec
> 4KB-mod     4KB-mod     3.245 Gbits/sec
> 4KB-mod     4KB         3.258 Gbits/sec
> 4KB         4KB         3.292 Gbits/sec
> 4KB         4KB-mod     3.265 Gbits/sec
> 4KB         64KB        3.189 Gbits/sec
> 
> 4KB-mod: Linux with the 64KB patch series
> 4KB: linux/master
> 
> The network performance is slightly worst with this series (-0.15%). I suspect,
> this is because of using an indirection to setup the grant. This is necessary
> in order to ensure that the grant will be correctly sized no matter of the
> Linux page granularity. This could be used later in order to support bigger
> grant.

I didn't compute correctly the result. It's -1.5% and not -0.15% sorry.

-- 
Julien Grall
