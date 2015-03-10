From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 Mar 2015 10:24:13 +0000
Subject: [PATCH] ARM: l2c: enforce use of cache-level property
In-Reply-To: <CACRpkdaFvQ9mqnNRrj0j1YAeLQ3xUeUokQv-81AL6gxDeU+iWQ@mail.gmail.com>
References: <1425408941-9897-1-git-send-email-f.fainelli@gmail.com>
 <CACRpkdaFvQ9mqnNRrj0j1YAeLQ3xUeUokQv-81AL6gxDeU+iWQ@mail.gmail.com>
Message-ID: <20150310102413.GJ8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 09, 2015 at 03:42:14PM +0100, Linus Walleij wrote:
> On Tue, Mar 3, 2015 at 7:55 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> 
> > Make sure that we can read the "cache-level" property from the L2 cache
> > controller node, and ensure its value is 2.
> >
> > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> (...)
> > +       if (of_property_read_u32(np, "cache-level", &cache_level))
> > +               pr_err("L2C: device tree omits to specify cache-level\n");
> > +
> 
> Is that really an error? Does ePAPR specify that this must always be
> present or what?

See table 3-9.  It appears to be a required property.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
