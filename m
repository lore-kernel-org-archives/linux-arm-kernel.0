From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 25 Jan 2017 11:45:03 +0100
Subject: [PATCH 1/3] coresight: fix kernel panic caused by invalid CPU
In-Reply-To: <1485193284-31636-2-git-send-email-mathieu.poirier@linaro.org>
References: <1485193284-31636-1-git-send-email-mathieu.poirier@linaro.org>
 <1485193284-31636-2-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20170125104503.GA13493@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 23, 2017 at 10:41:22AM -0700, Mathieu Poirier wrote:
> From: Wang Nan <wangnan0@huawei.com>
> 
> Commit d52c9750f150 ("coresight: reset "enable_sink" flag when need be")
> caused a kernel panic because of the using of an invalid value: after
> 'for_each_cpu(cpu, mask)', value of local variable 'cpu' become invalid,
> causes following 'cpu_to_node' access invalid memory area.

You should add a "Fixes:" tag when you write something like this, as you
have all of the information here. I'll add it, and the stable tag as
well...

thanks,

greg k-h
