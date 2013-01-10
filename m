From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 10 Jan 2013 14:04:02 -0500 (EST)
Subject: [PATCH 03/16] ARM: b.L: introduce helpers for platform coherency
 exit/setup
In-Reply-To: <20130110120144.GB29952@linaro.org>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
 <1357777251-13541-4-git-send-email-nicolas.pitre@linaro.org>
 <20130110120144.GB29952@linaro.org>
Message-ID: <alpine.LFD.2.02.1301101400060.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 10 Jan 2013, Dave Martin wrote:

> > +int __init bL_cluster_sync_init(void (*power_up_setup)(void))
> 
> The addition of the affinity level parameter for power_up_setup means
> that this prototype is not correct.

Indeed.

> This is not a functional change, since that function is only called from
> assembler anyway, but it will help avoid confusion.

Fixed now, as well as the DCSCB usage.


Nicolas
