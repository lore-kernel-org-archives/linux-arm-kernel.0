From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 30 Jul 2014 10:55:59 +0200
Subject: [RFC 4/5] regulator: tps65090: Set voltage for fixed regulators
In-Reply-To: <20140729173631.GX17528@sirena.org.uk>
References: <1406651339-28901-1-git-send-email-javier.martinez@collabora.co.uk>
 <1406651339-28901-5-git-send-email-javier.martinez@collabora.co.uk>
 <20140729173631.GX17528@sirena.org.uk>
Message-ID: <53D8B31F.6040404@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/29/2014 07:36 PM, Mark Brown wrote:
> On Tue, Jul 29, 2014 at 06:28:58PM +0200, Javier Martinez Canillas wrote:
> 
>> +#define tps65090_REG_VAR(_id, _sname, en_reg, _en_bits, _ops) \
>> +	tps65090_REG_DESC(_id, _sname, en_reg, _en_bits, 0, 0, _ops)
> 
> I'd expect this to describe a variable regulator when in fact it
> seems it describes a switch with no regulation.  Better name please.
> 

Yes, when writing the patch I thought of a switch as a non-fixed regulator whose
output voltage is variable and depend on its input supply voltage. That's why I
used VAR but I agree that is a bad name and I'll change it.

Thanks a lot and best regards,
Javier
