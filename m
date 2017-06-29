From: will.deacon@arm.com (Will Deacon)
Date: Thu, 29 Jun 2017 11:08:36 +0100
Subject: [PATCH] arm64: fix endianness annotation for 'struct jit_ctx'
 and friends
In-Reply-To: <20170628145803.24543-1-luc.vanoostenryck@gmail.com>
References: <20170628145803.24543-1-luc.vanoostenryck@gmail.com>
Message-ID: <20170629100835.GE14607@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 28, 2017 at 04:58:03PM +0200, Luc Van Oostenryck wrote:
> struct jit_ctx::image is used the store a pointer to the jitted
> intructions, which are always little-endian. These instructions
> are thus correctly converted from native order to little-endian
> before being stored but the pointer 'image' is declared as for
> native order values.
> 
> Fix this by declaring the field as __le32* instead of u32*.
> Same for the pointer used in jit_fill_hole() to initialize
> the image.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  arch/arm64/net/bpf_jit_comp.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Happy to take this via the arm64 tree, along with the other sparse fixes
(modulo review comments).

Ok with you, David?

Will
