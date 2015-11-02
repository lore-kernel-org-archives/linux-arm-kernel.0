From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 2 Nov 2015 13:40:25 +0000
Subject: [PATCH DRAFT 1/2] drivers: serial: PL011: refactor register access
In-Reply-To: <563764B7.6040202@codeaurora.org>
References: <1446467042-24494-1-git-send-email-andre.przywara@arm.com>
 <1446467042-24494-2-git-send-email-andre.przywara@arm.com>
 <563764B7.6040202@codeaurora.org>
Message-ID: <563767C9.7050206@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Timur,

On 02/11/15 13:27, Timur Tabi wrote:
> Andre Przywara wrote:
>> * to support UARTs with different register offsets (ZTE)
>> * to support a different bus access width (16 bits vs. 32 bits)
> 
> How exactly does this patch provide this?  The code is still calling a
> fixed function.  How will the code dynamically call a 32-bit version
> instead of a 16-bit version on platforms that need it?

This patch doesn't, I was just enumerating possible extensions which
will become much easier now that we don't have to patch every single
call site for such a change (to give rationale for this refactoring).
Changing the access width is now a simple change in those two functions,
and since you have the struct uart_amba_port available, you can access
any field in there to determine your desired access width.

As it says on the tin: it's a draft. Feel free to extend it to a proper
series ;-)

Cheers,
Andre.
