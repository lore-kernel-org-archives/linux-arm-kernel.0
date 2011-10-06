From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 6 Oct 2011 22:52:29 +0200
Subject: [PATCHv2] hw_random: add driver for atmel true hardware random
	number generator
In-Reply-To: <87ty7l3l5b.fsf@macbook.be.48ers.dk>
References: <1317923791-31200-1-git-send-email-jacmet@sunsite.dk>
	<20111006203023.GE24034@tarshish>
	<87ty7l3l5b.fsf@macbook.be.48ers.dk>
Message-ID: <20111006205229.GF24034@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Thu, Oct 06, 2011 at 10:44:32PM +0200, Peter Korsgaard wrote:
> >>>>> "Baruch" == Baruch Siach <baruch@tkos.co.il> writes:
>  >> +static int atmel_trng_read(struct hwrng *rng, void *buf, size_t max,
>  >> +			   bool wait)
>  >> +{
>  >> +	struct atmel_trng *trng = container_of(rng, struct atmel_trng, rng);
>  >> +	u32 *data = buf;
>  >> +
>  >> +	/* data ready? */
>  >> +	if (readl(trng->base + TRNG_ODATA) & 1) {
>  >> +		*data = readl(trng->base + TRNG_ODATA);
>  >> +		return 4;
> 
>  Baruch> Shouldn't you check for max >= 4 before writing to *buf?
> 
> Conceptually, yes. The other hw_random drivers don't seem to do it
> though, and the buffer size is guaranteed to be atleast 32 bytes, 

Ah, you're right, I missed that.

> but I can stick a '&& max >= 4' in the conditional if you prefer.

It probably doesn't worth the trouble, and the little added overhead. Thanks 
for the explanation.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
