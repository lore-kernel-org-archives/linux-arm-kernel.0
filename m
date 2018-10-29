From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Oct 2018 16:26:13 +0100
Subject: [PATCH v4 2/4] arm64: Add Mellanox BlueField SoC config option
In-Reply-To: <DB6PR05MB32236AAD033C20DF6414C464A1F30@DB6PR05MB3223.eurprd05.prod.outlook.com>
References: <b143b40446c1870fb8d422b364ead95d54552be9.1527264077.git.lsun@mellanox.com>
 <1540403734-137721-1-git-send-email-lsun@mellanox.com>
 <1540403734-137721-2-git-send-email-lsun@mellanox.com>
 <CAK8P3a1jTsvzYhS4CxvmK6tOgPn_g7=1S4xAcca2K4v70vhyEA@mail.gmail.com>
 <AM4PR05MB32204021433BBB853C50FF30A1F00@AM4PR05MB3220.eurprd05.prod.outlook.com>
 <CAK8P3a2=shWVjwrmnNTwwGwN_jhwyb+TmeALz4zzTstho51z8A@mail.gmail.com>
 <DB6PR05MB32236AAD033C20DF6414C464A1F30@DB6PR05MB3223.eurprd05.prod.outlook.com>
Message-ID: <CAK8P3a2_0mYaJ0NjWSMxpmoF9+tcoHtfhJQJ0Aj9Tds+f7KuEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 29, 2018 at 3:58 PM Liming Sun <lsun@mellanox.com> wrote:
> > It would be nice if you could still include the dts sources in the submission.
> > Since this is not a classic server hardware, DT is probably more suitable
> > here, and there are likely use cases that won't work with ACPI, so it's
> > good to have a starting point for your users if they need to override
> > the ACPI tables with a DT, or build systems with a simpler boot loader.
>
> Sure, I'll keep this DT change for reference. A little explanation that
> Mellanox BlueField SOC could be PCIe NIC or standalone device (server)  form which
> can do PXE boot, CentOS installation even on the NIC, etc. The same software/driver
> works on both.

Ok, good.

>  DT seems not working well for some requirement/features like
> NVDIMM (which requires ACPI DSM).  That's why we switched to ACPI though
> DT support is preserved.

This is probably something we need to look at separately, I'm sure we will want
to use NVDIMM with DT based systems in the future. Can you explain what
the DSM is used for here? Is this something that could be done in software
in the NVDIMM hardware specific driver?

       Arnd
