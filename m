From: james.morse@arm.com (James Morse)
Date: Tue, 12 Dec 2017 18:17:48 +0000
Subject: [RESEND PATCH V2] arm64: fault: avoid send SIGBUS two times
In-Reply-To: <20171211160536.11600-1-gengdongjiu@huawei.com>
References: <20171211160536.11600-1-gengdongjiu@huawei.com>
Message-ID: <5A301D4C.6070906@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dongjiu Geng,

On 11/12/17 16:05, Dongjiu Geng wrote:
> do_sea() calls arm64_notify_die() which will always signal
> user-space. It also returns whether APEI claimed the external
> abort as a RAS notification. If it returns failure do_mem_abort()
> will signal user-space too.
> 
> do_mem_abort() wants to know if we handled the error, we always
> call arm64_notify_die() so can always return success.
> 
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>

Reviewed-by: James Morse <james.morse@arm.com>


Nit: Your 'RESEND V2' and 'V2' are not the same patch.
'RESEND' is to indicate you're reposting exactly the same patch, usually with a
fixed CC list. Anyone who receives both can ignore one as you've said they are
the same.



Thanks,

James
