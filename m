From: horms@verge.net.au (Simon Horman)
Date: Wed, 28 Feb 2018 07:49:11 +0100
Subject: [PATCH 2/4] dt-bindings: arm: Document Renesas V3MSK and Wheat
 board part numbers
In-Reply-To: <CAMuHMdWqdFKH7AoFNAX5tHrCSn+cT5KTW38d8_CxYWJ76xGBMg@mail.gmail.com>
 <36c4cab2-3e41-d5ed-27a4-5a297887cf10@cogentembedded.com>
Message-ID: <20180228064911.vnax4vyqnq6lry52@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 27, 2018 at 01:47:09PM +0300, Sergei Shtylyov wrote:
> Hello!
> 
> On 02/27/2018 11:17 AM, Simon Horman wrote:

...

> >> diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
> >> index ded2cd3b5f4df0c8..82908a9447e4b051 100644
> >> --- a/Documentation/devicetree/bindings/arm/shmobile.txt
> >> +++ b/Documentation/devicetree/bindings/arm/shmobile.txt
> >> @@ -120,9 +120,9 @@ Boards:
> >>      compatible = "renesas,sk-rzg1m", "renesas,r8a7743"
> >>    - Stout (ADAS Starterkit, Y-R-CAR-ADAS-SKH2-BOARD)
> >>      compatible = "renesas,stout", "renesas,r8a7790"
> >> -  - V3MSK
> >> +  - V3MSK (Y-ASK-RCAR-V3M-WS10)
> 
>    ACK.
> 
> >>      compatible = "renesas,v3msk", "renesas,r8a77970"
> > 
> > Google also tells me there is WS20, but I guess WS10 what is
> > currently supported upstream.
> 
>    At least that's what I have on my desk. :-)
> 
> >> -  - Wheat
> >> +  - Wheat (RTP0RC7792ASKB0010JE)
> >>      compatible = "renesas,wheat", "renesas,r8a7792"
> > 
> > I'm unable to confirm the above. Can anyone help?
> 
>    Not me -- my documents don't mention this. :-(

On Tue, Feb 27, 2018 at 10:14:32PM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Tue, Feb 27, 2018 at 9:17 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Mon, Feb 26, 2018 at 07:03:43PM +0100, Geert Uytterhoeven wrote:

...

> >> -  - Wheat
> >> +  - Wheat (RTP0RC7792ASKB0010JE)
> >>      compatible = "renesas,wheat", "renesas,r8a7792"
> >
> > I'm unable to confirm the above. Can anyone help?
> 
> https://elinux.org/R-Car/Boards/Wheat
> 
> Looks like I misinterpreted the pictures, and
> RTP0RC7792ASKB0000JE is the correct part number for Wheat.

Thanks. I've applied the following.


From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dt-bindings: arm: Document Renesas V3MSK and Wheat board part
 numbers

The DT binding documentation for the Renesas V3MSK and Wheat boards
lacked board part numbers.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[simon: corrected Wheat part number]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index a99359e63b0a..66edc1406bb8 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -120,9 +120,9 @@ Boards:
     compatible = "renesas,sk-rzg1m", "renesas,r8a7743"
   - Stout (ADAS Starterkit, Y-R-CAR-ADAS-SKH2-BOARD)
     compatible = "renesas,stout", "renesas,r8a7790"
-  - V3MSK
+  - V3MSK (Y-ASK-RCAR-V3M-WS10)
     compatible = "renesas,v3msk", "renesas,r8a77970"
-  - Wheat
+  - Wheat (RTP0RC7792ASKB0000JE)
     compatible = "renesas,wheat", "renesas,r8a7792"
 
 
-- 
2.11.0
