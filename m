From: hramrach@gmail.com (Michal Suchanek)
Date: Wed, 12 Aug 2015 14:30:19 +0200
Subject: [linux-sunxi] MMC clock gating broken on a20
In-Reply-To: <55CB344F.6050608@schinagl.nl>
References: <CAOMqctRhQHv1idY0ci6uzDxnv5oj7dbHtc4CTfo75ipXkXd1gw@mail.gmail.com>
 <55CB3095.9050509@schinagl.nl> <55CB344F.6050608@schinagl.nl>
Message-ID: <CAOMqctSSyJs_yAkjDd0OCM2c3BanaBd7cr5kREn6b5ckStyzSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 August 2015 at 13:55, Olliver Schinagl <oliver+list@schinagl.nl> wrote:
> Actually, I've reverted hans's
>
> mmc: sunxi: Don't start commands while the card is busy
>
> and that makes it disapear as well. So it looks like that patch triggers the
> aggressiveness more?

It probably inserts delays which trigger the mmc power saving.

Still the delay should not be needed on the mmc interface which is
connected to the card slot, should it?

Thanks

Michal
