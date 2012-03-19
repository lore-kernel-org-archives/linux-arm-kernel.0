From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Mar 2012 08:55:03 +0000
Subject: [PATCH] ARM: lib: use LDRD/STRD for data copy
In-Reply-To: <007201cd059e$4af2cc10$e0d86430$%kim@samsung.com>
References: <007201cd059e$4af2cc10$e0d86430$%kim@samsung.com>
Message-ID: <20120319085503.GL15988@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 19, 2012 at 04:02:48PM +0900, Boojin Kim wrote:
> This patch uses LDRD/STRD that loads and stores data as DWORD unit
> for the copy of 8-words data.
> It brings better performance than LDRM/STRM that was used originally.

And what about CPUs that don't have ldrd/strd ?
