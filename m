From: moorray3@wp.pl (Jakub =?UTF-8?B?S2ljacWEc2tp?=)
Date: Tue, 12 May 2015 16:00:27 +0200
Subject: [PATCH] serial/amba-pl011: Unconditionally poll for FIFO space
 before each TX char
In-Reply-To: <1431438266-28094-1-git-send-email-Dave.Martin@arm.com>
References: <1431438266-28094-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <20150512160027.21244f64@north>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 12 May 2015 14:44:26 +0100, Dave Martin wrote:
> This will cause a conflict with tty-next because it pulls forward
> some changes made by commit 1e84d22 (serial/amba-pl011: Refactor and
> simplify TX FIFO handling); however, the resolution is simple except
> for the following lines which may need to be deleted manually from
> amba-pl011.c:pl011_startup():

By resolution is simple you mean: keep the code as it is in tty-next,
right?
