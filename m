From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Sun, 6 Sep 2009 22:04:38 +0400
Subject: zaurus c3000 aka spitz: fix resume
In-Reply-To: <20090906052840.GF1324@ucw.cz>
References: <20090906052840.GF1324@ucw.cz>
Message-ID: <20090906180438.GA6835@doriath.ww600.siemens.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 06, 2009 at 07:28:40AM +0200, Pavel Machek wrote:
> 
> sharpsl_pm.c code tries to read battery state very early during
> resume, but those battery meters are connected on SPI and that's only
> resumed way later.
> 
> Replace the check with simple checking of battery fatal signal, that
> actually works at this stage.

Nice catch! Unfortunately I can't test the patch ATM, but it seems
resonable.

-- 
With best wishes
Dmitry
