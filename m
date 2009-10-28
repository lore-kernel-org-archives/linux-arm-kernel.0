From: schwarzb@ipms.fraunhofer.de (Markus Schwarzenberg)
Date: Wed, 28 Oct 2009 14:47:48 +0100
Subject: S3C6400 SMDK6400 HSMMC problem
In-Reply-To: <20091026153139.GC8096@trinity.fluff.org>
References: <20091022172716.2c20c1a8@linpcd55>
	<20091026153139.GC8096@trinity.fluff.org>
Message-ID: <20091028144748.3a01adfa@linpcd55>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 26 Oct 2009 15:31:40 +0000 Ben Dooks <ben@trinity.fluff.org> wrote:

> > However the kernel's sdhci driver has problems (I/O errors) using the same
> > S3C6400 HSMMC 0 (see below) when trying to mount the root partition from
> > the SD Card.
> 
> It is possible there is a problem with the setup data being passed for
> the system, since the controller has some feedback controls that are
> in an extended part of the SDHCI controller space.

thanks. now it turned out that with unrecommended feedback control 
settings (FCSEL[2]=0 for for Normal Speed mode) the I/O errors are gone.

in the original setup arch/arm/mach-s3c6400/setup-sdhci.c it's done 
as recommended by Samsung and the same way it's done in OpenMoko/qi.

--
Markus
