From: mroberto@cpti.cetuc.puc-rio.br (Marcelo Jimenez)
Date: Wed, 31 Mar 2010 11:41:07 -0300
Subject: [PATCH] ARM: pcmcia: Adds nanoEngine PCMCIA support.
In-Reply-To: <20100331070648.GA23391@pengutronix.de>
References: <1269972879-27400-1-git-send-email-mroberto@cpti.cetuc.puc-rio.br>
	<20100331070648.GA23391@pengutronix.de>
Message-ID: <q2ncecb6d8f1003310741g542debabs1fd8044983cc1c37@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolgram,

On Wed, Mar 31, 2010 at 04:06, Wolfram Sang <w.sang@pengutronix.de> wrote:
> Hi Marcelo,
>
> On Tue, Mar 30, 2010 at 03:14:39PM -0300, Marcelo Roberto Jimenez wrote:
>> This patch adds nanoEngine PCMCIA support, with support for two sockets.
>> ...
>> +
>> + ? ? memset(state, 0, sizeof(struct pcmcia_state));
>> + ? ? switch (i) {
>> + ? ? case 0:
>> + ? ? ? ? ? ? state->ready ? ?= ?(levels & GPIO_PC_READY0) ? ?? 1 : 0;
>> + ? ? ? ? ? ? state->detect ? = !(levels & GPIO_PC_CD0) ? ? ? ? 1 : 0;
>
> If lines are added at a later stage, all this indentation might have to be
> redone. This breaks 'git blame'. Please just one space around operators as
> suggested in CodingStyle, chapter 3.1.

Sorry, I didn't know about that. I ran the patch through checkpatch.pl
and it did not complain, so I thought it was ok. I will change that
and resubmit.

>> +
>> +int pcmcia_nanoengine_init(struct device *dev)
>> +{
>> + ? ? int ret = -ENODEV;
>> +
>> + ? ? printk(KERN_INFO "BSE nanoEngine pcmcia support by "
>> + ? ? ? ? ? ? "Miguel Freitas & Marcelo Jimenez.\n");
>
> Is this really necessary? Log would get quite messy if all drivers do this.
> I haven't checked, can't you just use MODULE_AUTHOR here?

I can remove it, in fact. It was there at the first version of the
driver, so I just added my name. In this case, this file becomes part
of another module, in this case the module is "sa1100_cs", so I don't
think I could add MODULE_AUTHOR there, but I could use some advice
here.

>
> --
> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | Wolfram Sang ? ? ? ? ? ? ? ?|
> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|

Thanks for your comments,
Marcelo.
