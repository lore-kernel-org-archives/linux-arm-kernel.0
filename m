From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 24 Mar 2017 19:19:34 +0300
Subject: [PATCH 1/3] crypto: hw_random - Add new Exynos RNG driver
In-Reply-To: <9265537.P6AeF50kg8@amdc3058>
References: <20170324142446.31129-1-krzk@kernel.org>
 <3940941.n3qdgn1RbN@amdc3058>
 <20170324154600.lavc22dbw7rtioli@kozik-lap>
 <CGME20170324161128epcas1p4b9ef08e3d7e640957d30afa84aa66a16@epcas1p4.samsung.com>
 <9265537.P6AeF50kg8@amdc3058>
Message-ID: <20170324161934.kc6g36nazr3y32kp@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 24, 2017 at 05:11:25PM +0100, Bartlomiej Zolnierkiewicz wrote:
> On Friday, March 24, 2017 06:46:00 PM Krzysztof Kozlowski wrote:
> > I really do not like global or file-scope variables. I do not like
> > drivers using them. Actually I hate them.
> > 
> > From time to time I encounter a driver which was designed with that
> > approach - static fields and hidden assumption that there will be only
> > one instance. Usually that assumption is really hidden...
> > 
> > ... and then it happens that I want to use two instances which of course
> > fails.
> > 
> > This code serves as a clear documentation for this assumption - only one
> > instance is allowed. You can look at it as a self-documenting
> > requirement.
> 
> For me it looks as needless case of defensive programming and when
> I see the code like this it always raises questions about the real
> intentions of the code. I find it puzzling and not helpful.

I do not understand what might be puzzling about check for static
file-scope value. It is of course subjective, but for me that looks
pretty self-explanatory.

> 
> > And I think the probe might be called twice, for example in case of
> > mistake in DTB.
> 
> Even if this is possible resource allocation code in the driver will
> take take care of handling it just fine,

Indeed, the devm_ioremap_resource() solves the case. I can drop the
check then.

Best regards,
Krzysztof
