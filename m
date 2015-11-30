From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Mon, 30 Nov 2015 16:57:23 +0100
Subject: [PATCH 1/3] i2c: at91: add setting HOLD field of TWIHS_CWGR via DT
In-Reply-To: <20151130151319.GM1513@katana>
References: <1448372862-11912-1-git-send-email-ludovic.desroches@atmel.com>
 <20151130151319.GM1513@katana>
Message-ID: <20151130155723.GA29282@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 30, 2015 at 04:13:20PM +0100, Wolfram Sang wrote:
> On Tue, Nov 24, 2015 at 02:47:40PM +0100, Ludovic Desroches wrote:
> > From: Wenyou Yang <wenyou.yang@atmel.com>
> > 
> > Add the HOLD field management. Some i2c devices need a longer data hold
> > time than the one given in the i2c bus specification. Since this value
> > depends on the i2c device connected to the bus, add a DT property to
> > configure it: "atmel,twd-hold-cycles".
> 
> We already have "i2c-sda-hold-time-ns". Can you use that one? Sorry that
> this is not obviously documented, I am working on it...
> 

I think we can use it, I'll rework the patch to convert duration in
number of cycles.
