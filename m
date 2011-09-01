From: jamie@jamieiles.com (Jamie Iles)
Date: Thu, 1 Sep 2011 08:58:15 +0100
Subject: [PATCHv2 3/3] picoxcell: add the DTS for the PC7302 board
In-Reply-To: <CAGsJ_4wp8aSJ2Kug2FkAznbVA9ifLfHt95P8+9bUijKAqJj5kA@mail.gmail.com>
References: <1314196906-20709-1-git-send-email-jamie@jamieiles.com>
	<1314196906-20709-4-git-send-email-jamie@jamieiles.com>
	<CAGsJ_4wp8aSJ2Kug2FkAznbVA9ifLfHt95P8+9bUijKAqJj5kA@mail.gmail.com>
Message-ID: <20110901075815.GA2585@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 01, 2011 at 02:36:17PM +0800, Barry Song wrote:
> 2011/8/24 Jamie Iles <jamie@jamieiles.com>:
[...]
> > + ? ? ? clocks {
> > + ? ? ? ? ? ? ? ref_clk: clock at 10 {
> > + ? ? ? ? ? ? ? ? ? ? ? compatible = "fixed-clock";
> > + ? ? ? ? ? ? ? ? ? ? ? clock-outputs = "ref";
> > + ? ? ? ? ? ? ? ? ? ? ? clock-frequency = <20000000>;
> > + ? ? ? ? ? ? ? };
> 
> ok. find it. is its name just "ref_clk"? could it be a pll/osc or some
> meaningful name?

Well it's the board reference clock.  Typically this is a crystal, but 
can also be an accurate, external reference or a VCTCXO so it didn't 
feel right to encode that into the name for the SoC DTSI.  I guess it 
could be called board_clk if that makes things easier though.

Jamie
