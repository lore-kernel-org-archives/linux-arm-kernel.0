From: gregkh@linuxfoundation.org (Greg KH)
Date: Mon, 23 Apr 2018 12:52:24 +0200
Subject: [PATCH v3 03/10] drivers/peci: Add support for PECI bus driver
 core
In-Reply-To: <20180410183212.16787-4-jae.hyun.yoo@linux.intel.com>
References: <20180410183212.16787-1-jae.hyun.yoo@linux.intel.com>
 <20180410183212.16787-4-jae.hyun.yoo@linux.intel.com>
Message-ID: <20180423105224.GA1444@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 10, 2018 at 11:32:05AM -0700, Jae Hyun Yoo wrote:
> +static void peci_adapter_dev_release(struct device *dev)
> +{
> +	/* do nothing */
> +}

As per the in-kernel documentation, I am now allowed to make fun of you.

You are trying to "out smart" the kernel by getting rid of a warning
message that was explicitly put there for you to do something.  To think
that by just providing an "empty" function you are somehow fulfilling
the API requirement is quite bold, don't you think?

This has to be fixed.  I didn't put that warning in there for no good
reason.  Please go read the documentation again...

greg k-h
