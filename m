From: robh@kernel.org (Rob Herring)
Date: Wed, 23 May 2018 14:55:45 -0500
Subject: [PATCH 1/6] dt-bindings: media: rcar-vin: Describe optional ep
 properties
In-Reply-To: <1709653.qERUERh18a@avalon>
References: <1526488352-898-1-git-send-email-jacopo+renesas@jmondi.org>
 <1526488352-898-2-git-send-email-jacopo+renesas@jmondi.org>
 <20180523162947.GA13661@rob-hp-laptop> <1709653.qERUERh18a@avalon>
Message-ID: <CAL_JsqKAku8JPC_aX40Q59QiNkO9r8qY=pCrOLF13mbQXYpTgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 23, 2018 at 2:38 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Rob,
>
> On Wednesday, 23 May 2018 19:29:47 EEST Rob Herring wrote:
>> On Wed, May 16, 2018 at 06:32:27PM +0200, Jacopo Mondi wrote:
>> > Describe the optional endpoint properties for endpoint nodes of port at 0
>> > and port at 1 of the R-Car VIN driver device tree bindings documentation.
>> >
>> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
>> > ---
>> >
>> >  Documentation/devicetree/bindings/media/rcar_vin.txt | 13 ++++++++++++-
>> >  1 file changed, 12 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/Documentation/devicetree/bindings/media/rcar_vin.txt
>> > b/Documentation/devicetree/bindings/media/rcar_vin.txt index
>> > a19517e1..c53ce4e 100644
>> > --- a/Documentation/devicetree/bindings/media/rcar_vin.txt
>> > +++ b/Documentation/devicetree/bindings/media/rcar_vin.txt
>> > @@ -53,6 +53,16 @@ from local SoC CSI-2 receivers (port1) depending on
>> > SoC.
>> >
>> >        from external SoC pins described in video-interfaces.txt[1].
>> >        Describing more then one endpoint in port 0 is invalid. Only VIN
>> >        instances that are connected to external pins should have port 0.
>> >
>> > +
>> > +      - Optional properties for endpoint nodes of port at 0:
>> > +        - hsync-active: active state of the HSYNC signal, 0/1 for
>> > LOW/HIGH
>> > +     respectively. Default is active high.
>> > +        - vsync-active: active state of the VSYNC signal, 0/1 for
>> > LOW/HIGH
>> > +     respectively. Default is active high.
>> > +
>> > +   If both HSYNC and VSYNC polarities are not specified, embedded
>> > +   synchronization is selected.
>>
>> No need to copy-n-paste from video-interfaces.txt. Just "see
>> video-interfaces.txt" for the description is fine.
>
> I would still explicitly list the properties that apply to this binding. I
> agree that there's no need to copy & paste the description of those properties
> though.

Yes, that's what I meant. List each property with "see
video-interfaces.txt" for the description of each.

Rob
