From: robh@kernel.org (Rob Herring)
Date: Sun, 9 Jul 2017 22:50:31 -0500
Subject: [PATCH 3/3] dt-bindings: clock: amlogic,gxbb-aoclkc: Update
 bindings
In-Reply-To: <1499336663-23875-4-git-send-email-narmstrong@baylibre.com>
References: <1499336663-23875-1-git-send-email-narmstrong@baylibre.com>
 <1499336663-23875-4-git-send-email-narmstrong@baylibre.com>
Message-ID: <20170710035031.rdbi64ookkbq6zeo@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 06, 2017 at 12:24:23PM +0200, Neil Armstrong wrote:
> On the first revision of the bindings, only the gates + resets were known
> in the AO Clock HW, but more registers used to configures AO clock are known
> to be spread among the AO register space.
> This patch adds these registers to the Ao Clock bindings with direct access
> and shared extcon access.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt         | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

This looks like the binding might be too specific with a reg list of 
single registers, and you should define a system controller node 
instead. Depends on what else is in the "A0" block.

Acked-by: Rob Herring <robh@kernel.org>
