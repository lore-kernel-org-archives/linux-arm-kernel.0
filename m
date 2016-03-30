From: maitysanchayan@gmail.com (maitysanchayan at gmail.com)
Date: Wed, 30 Mar 2016 12:02:46 +0530
Subject: [RFC PATCH 0/4] Implement USB device/host switch for Vybrid
In-Reply-To: <HE1PR04MB1450691A838973845B7AD16F8B870@HE1PR04MB1450.eurprd04.prod.outlook.com>
References: <cover.1458030082.git.maitysanchayan@gmail.com>
 <20160325074051.GB22398@peterchendt>
 <3c2e72efc8cae93ff31be1b44f9a02b3@agner.ch>
 <HE1PR04MB1450691A838973845B7AD16F8B870@HE1PR04MB1450.eurprd04.prod.outlook.com>
Message-ID: <20160330063246.GA16028@Sanchayan-Arch.toradex.int>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Peter,

On 16-03-29 00:24:46, Peter Chen wrote:
>  
> > 
> > On 2016-03-25 00:40, Peter Chen wrote:
> > > On Tue, Mar 15, 2016 at 02:08:26PM +0530, Sanchayan Maity wrote:
> > >> Hello Peter,
> > >>
> > >> The existing usage of extcon in Chipidea driver relies on OTG
> > >> registers. In case of SoC with dual role device but not a true OTG
> > >> controller, this does not work. Such SoC's should specify the
> > >> existing CI_HDRC_DUAL_ROLE_NOT_OTG flag and do the role switch
> > >> without checking any of the OTG registers in my opinion.
> > >> This is the case for Vybrid which uses a Chipidea IP but does not
> > >> have a true 5 pin OTG implemented.
> > >
> > > Sorry to reply you late due to my new born baby.
> > >
> > > Are you sure Vybrid is NOT OTG core? Afaik, it is uses the same IP
> > > base with other Freescale SoCs, just the IP core is 2.40a.
> > > When working at device mode, can you read vbus status through OTGSC?
> > > And if there is an ID pin (input pin) for Vybrid? I mean SoC, not the
> > > board.
> > 
> > I think the IP is actually OTG capable, the registers are there, but the signals
> > seem not to be available on the SoC package. That is also what the RM says...
> > 
> > Quotes from the RM:
> > 
> > "OTG controller should be treated as
> > Dual role controller that allows the
> > controller to act as either a Host or a
> > device with no support for HNP/SRP."
> > 
> > And later, in Chapter 11.1:
> > 
> > "The USB is not a true OTG. It can be configured by software to function either
> > as peripheral or as host. The ID pin, which is unique for OTG operation, is not
> > present in this implementation. There are no five pin interface. The user will
> > get four pin host/ device interface."
> > 
> 
> Get it, thanks. I am doing a patch for covering this case and vbus always-on case.

If I may ask at this point, how would your implementation be covering this case
for Vybrid?

- Sanchayan.
