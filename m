From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Wed, 7 Sep 2016 11:18:19 +0200
Subject: [PATCH v11 3/4] tee: add OP-TEE driver
In-Reply-To: <49a564fc-0d45-9981-b357-a1046a135d33@hisilicon.com>
References: <1471870856-18684-1-git-send-email-jens.wiklander@linaro.org>
 <1471870856-18684-4-git-send-email-jens.wiklander@linaro.org>
 <49a564fc-0d45-9981-b357-a1046a135d33@hisilicon.com>
Message-ID: <20160907091818.GA15580@ermac>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Zengtao,

On Wed, Sep 07, 2016 at 03:49:38PM +0800, Zeng Tao wrote:
> Hi all:
> 
> I have gone through the patch, and i find one limit for RPC call from
> TEE to REE.  In this patch, RPC commands are fixed and it supports a
> limited set of commands.  If you want to add your own RPC command then
> you need to change the source code of the driver.

All unknown RPC of the OPTEE_SMC_RPC_FUNC_CMD type are forwarded to the
supplicant in user space. So there's the option to extend with the
supplicant if needed.

It is true that the RPCs which are dealt with in the driver are fixed.

> 
> I don't know how much work to do, but unless we are sure that the RPC
> now are enough to cover all, we 'd better make the RPC more
> extensible.

It's handle_rpc_func_cmd() that could support dynamic registration of
RPC commands. Doing so in optee_handle_rpc() also should be avoided as
it involves updates of an eventual hypervisor.

I'm trying to keep this initial patch set as small as possible to not
make it harder than it already is to review it. If possible I'd like to
wait with new features until after this patch set has been accepted.

Thanks,
Jens

> 
> BR zengtao
