From: daniel@zonque.org (Daniel Mack)
Date: Mon, 07 Apr 2014 16:11:24 +0200
Subject: Porting plat-pxa to the MMP PDMA driver
In-Reply-To: <20140407140256.GA13237@sirena.org.uk>
References: <5342A73F.8010907@zonque.org>
 <20140407140256.GA13237@sirena.org.uk>
Message-ID: <5342B20C.4070608@zonque.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/07/2014 04:02 PM, Mark Brown wrote:
> On Mon, Apr 07, 2014 at 03:25:19PM +0200, Daniel Mack wrote:
>> On 04/07/2014 03:12 PM, Laurent Pinchart wrote:
> 
>>> I'm writing instead of the legacy PXA DMA code. However, this
>>> requires porting the platform to the MMP PDMA driver first,
>>> which involves porting all the above drivers to the DMA engine
>>> API. The spi-pxa2xx driver has already been ported and
>>> currently supports both the legacy PXA DMA API and the DMA
>>> engine API. All the other drivers seem to require the legacy
>>> PXA DMA API.
> 
>>> I was wondering if any effort had been started in that
>>> direction. I could possibly help with the pxamci driver, but
>>> not with the other drivers as the corresponding peripherals are
>>> not used on my test platform (a custom PXA27x board).
> 
>> Yes, I've started working on this a long time ago, but got stuck
>> because of the lack of support from users, as I don't have
>> hardware with all possible DMA-capable components in use. Have a
>> look here, the tree should be easily rebasable onto newer
>> versions:
> 
> Is it not possible to do what we're doing with the Samsung
> platforms and have both platform and generic DMA code in the
> source, selected via a Kconfig symbol?  That way you don't have to
> have a flag day.

Not sure whether I'm following, but on PXA, the DMA controller can
either be used by the old framework or the new driver, and so users
can't choose which one to use. I thought about a macro hack to make
the transition easier, but that seems impossible to do.

Sure, we could keep implementations for both environments around, but
chances are that we'll never get rid of the old cruft at all then.
Also, for most drivers that means lots of code duplication.


Regards,
Daniel
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTQrIMAAoJELphMRr8Y1QkSzwP/3kAIGICW9nkst6Bx4Bb5xty
ACm0cexJCcS739IBB5ztSUGQaNPtB+d1js44TNU0maTmKrsjeVUBLzHYtz8DXezM
cJTWOodbqpzKVEanjOZiGLa7EWIyFdTjdaqzCzaRtxl4YSFeghF0H+PwQxrnzVq3
qHFWelsuXFOC3S3F6Mf4DfAf3JCVV681BqYFXEqnP92NcaYIrUnTwnCPSPtEIbPh
nNq+9r6nDVfEd8PLAAvMcwtWYPhD+ECg86zH/sdfTTNCwtEW59tHCm1mUxY3MhOR
jYCCvTBzL2DZuucdp1pxyifoIaQ3qjLc5kl0/cPZQ+j0aREnAgMewiJxbR/DR8SL
j84wHeYeudu/aPdNdfR3lvN00quyh3+K3uvLtjcBgpS2NLtwiA63PelmdG0RUUpI
mM5/X4z4cGFwQYjS+zF1oIplDqfeWoppd/hJWUco4TUn+SlAOjr2MX3zHR31Sr5t
E+RbQcsO3D/msNY+fMHk36LqK9zNAOacJR/Pw/8euJ0sr2tl5SBEpao2Lf81TvGr
6t7ufZ/xQ5PxUQUb7Fbe6/7snq+ECaR64DqMg6JXiU8tuPbJl5+HQ6oJSMuU8fCt
AUA4gvNG3spxH18CIy8pYlyNve4oHT0b+TBGaYGd7tQCsRN77eXLh0erbNK+GwFE
qA8hY3PJA1uhD1n4fOKY
=dkRF
-----END PGP SIGNATURE-----
