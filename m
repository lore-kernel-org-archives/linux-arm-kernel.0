From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 7 Oct 2015 13:55:31 +0100
Subject: [PATCH v2 1/3] nvmem: core: make default user binary file
 root-access only
In-Reply-To: <1444215647-10836-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1444215536-10783-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1444215647-10836-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <20151007125531.GA7962@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 07, 2015 at 12:00:47PM +0100, Srinivas Kandagatla wrote:
> As required by many providers like at24/at25/mxs-ocotp/qfprom and may be
> other providers would want to allow root-only to read the nvmem content.
> So making the defaults to be root-only access would address the request
> and also provide flexibility to providers to specify there own permissions
> on top of the root-only using the perm flag in nvmem_config.

Eeek, no, don't mess with different permissions, that's not ok, be
consistent and only allow root write access, that's why we have static
build-time checks to ensure you get this correct and do not accidentally
let a "normal" user access to things they shouldn't have access to.

> Making this dynamic did cut down lot of static binary attributes in the
> code.

Nothing wrong with static binary attributes, please use them instead.

thanks,

greg k-h
