From: nerv@dawncrow.de (=?ISO-8859-15?Q?Andr=E9_Hentschel?=)
Date: Sat, 18 May 2013 17:02:25 +0200
Subject: [PATCHv4] arm: Preserve the user r/w register TPIDRURW on context
 switch and fork
In-Reply-To: <518AA19B.2020209@dawncrow.de>
References: <518AA19B.2020209@dawncrow.de>
Message-ID: <51979801.7010903@dawncrow.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 08.05.2013 21:03, schrieb Andr? Hentschel:
> From: =?UTF-8?q?Andr=C3=A9=20Hentschel?= <nerv@dawncrow.de>
> 
> Since commit 6a1c53124aa1 the user writeable TLS register was zeroed to
> prevent it from being used as a covert channel between two tasks.
> 
> There are more and more applications coming to WinRT, Wine could support them,
> but mostly they expect to have the thread environment block (TEB) in TPIDRURW.
> 
> This patch preserves that register per thread instead of clearing it.
> Unlike the TPIDRURO, which is already switched, the TPIDRURW
> can be updated from userspace so needs careful treatment in the case that we
> modify TPIDRURW and call fork(). To avoid this we must always read
> TPIDRURW in copy_thread.
> 
> Signed-off-by: Andr? Hentschel <nerv@dawncrow.de>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Jonathan Austin <jonathan.austin@arm.com> 
> 

Hi,
I'm not yet very familiar with the development process here,
am i getting no feedback on v4 because of the mergewindow being closed?
Or is there another reason? Sry for being impatient.
