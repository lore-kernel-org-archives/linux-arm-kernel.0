From: sunil.kovvuri@gmail.com (Sunil Kovvuri)
Date: Tue, 11 Sep 2018 21:58:05 +0530
Subject: [PATCH v3 00/15] soc: octeontx2: Add RVU admin function driver
In-Reply-To: <CAK8P3a32gpNX42NuzmbW1PbsHpq7v7LoQ6WDeKtt=QiYbuyM7w@mail.gmail.com>
References: <1536078525-31534-1-git-send-email-sunil.kovvuri@gmail.com>
 <CA+sq2CdNRkbGrk4rHOQX1qHrRc2+=DXBscw7cD9UKrX4G5OaVg@mail.gmail.com>
 <CAK8P3a32gpNX42NuzmbW1PbsHpq7v7LoQ6WDeKtt=QiYbuyM7w@mail.gmail.com>
Message-ID: <CA+sq2CeOSY9VLEY6ruGceo+NkwtfDuivy9joMkx9P3JTPyZxZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 11, 2018 at 7:07 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Sep 11, 2018 at 2:37 PM Sunil Kovvuri <sunil.kovvuri@gmail.com> wrote:
> >
> > Didn't receive any feedback for the v3 patch series over a week's time.
> > Can you please pick up these patches to merge into arm-soc ?
>
> I would still prefer to see the whole thing as part of drivers/net/
> instead of drivers/soc,
> and reviewed in full on the netdev side, including the parts that are
> not ethernet specific.
>
>        Arnd

Hmm.. I agree that there are many networking terms used in the driver
but it's not a
networking driver, it's just a HW configuration driver which includes
how HW should
parse the packet. This driver doesn't fit into drivers/net.

Let's say if netdev driver in drivers/net/ethernet doesn't make use of
crypto feature
then i guess netdev maintainers would reject any patches which configure crypto
block. Also as i have been saying there are other scenarios as well.
Future silicons may add support for other features into this resource
virtualization unit's domain.
An example would be compression. Any patches which do compression
related HW configuration
might be rejected by netdev maintainers, cause they are no way related
to networking.

I will keep netdev mailing list in all the patch submissions but
moving this driver into drivers/net
doesn't sound right, from it's functionality perspective.

Thanks,
Sunil.
