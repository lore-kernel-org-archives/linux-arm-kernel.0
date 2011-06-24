From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 23 Jun 2011 22:05:00 -0600
Subject: [PATCH 1/3] serial/imx: add device tree support
In-Reply-To: <20110624034859.GB19188@S2100-06.ap.freescale.net>
References: <1308410354-21387-1-git-send-email-shawn.guo@linaro.org>
	<1308410354-21387-2-git-send-email-shawn.guo@linaro.org>
	<20110618161934.GH8195@ponder.secretlab.ca>
	<20110619073000.GA23171@S2100-06.ap.freescale.net>
	<20110621135558.GB9228@S2101-09.ap.freescale.net>
	<BANLkTim4vunTm1176MRw3pqRZnunu4=9jg@mail.gmail.com>
	<20110623183821.GA19188@S2100-06.ap.freescale.net>
	<BANLkTi=8Mks6T85WnEyihmB21U1j7reHrQ@mail.gmail.com>
	<20110624034859.GB19188@S2100-06.ap.freescale.net>
Message-ID: <BANLkTimXZvW16uMRGMeyH203e6MHxdNbSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 23, 2011 at 9:49 PM, Shawn Guo <shawn.guo@freescale.com> wrote:
> On Thu, Jun 23, 2011 at 05:11:54PM -0600, Grant Likely wrote:
>> > + ? ? ? ? ? ? ? int devid = get_alias_name_id(pp->name, devname);
>> > +
>> > + ? ? ? ? ? ? ? /* We do not want to proceed this sentinel one */
>> > + ? ? ? ? ? ? ? if (!strcmp(pp->name, "name") && !strcmp(pp->value, "aliases"))
>> > + ? ? ? ? ? ? ? ? ? ? ? break;
>>
>> Skipping the 'name' property is good, but I don't think you need to
>> check the value. ?You should also skip the "phandle" property.
>>
> Ok. I have not seen "phandle" property in aliases node though. ?Can
> you give me an example, so that I can make one up for testing?

It's a standard property that shows up automatically if any node
happens to have a phandle reference to another node.  The name will be
either "phandle" or "linux,phandle".  Search for "linux,phandle" in
drivers/of/fdt.c to see how that property is processed.

g.
