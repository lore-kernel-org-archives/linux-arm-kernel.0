From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 06 Nov 2014 12:56:27 +0100
Subject: gcc 4.9 build warnings (was: Re: arm-soc build: 2917 warnings 0
 failures (arm-soc/v3.18-rc1-20-g06c0773))
In-Reply-To: <20141106114919.GL26297@ulmo>
References: <544a2a2e.a2db440a.6eeb.ffffaef3@mx.google.com>
 <CAKv+Gu-0jenous5sLPp+QJa3qRk-RiBgG1vVYP_RmVw0uXaysw@mail.gmail.com>
 <20141106114919.GL26297@ulmo>
Message-ID: <2700572.p8cKrIiMH5@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 06 November 2014 12:49:22 Thierry Reding wrote:
> GCC complains about the format specifier being wrong. %zu/%zd are the
> correct specifiers for variables of type size_t/ssize_t, so wherever a
> size_t or ssize_t is used as parameter it should have a corresponding
> %zu or %zd specifier.
> 
> Why not just fix it properly instead of mucking about with the size_t
> typedef?
> 

Yes, but where are %zu and %zd implemented in gcc? I've looked but
couldn't find it. For all I can tell is that gcc's own interpretation
of %z doesn't match its definition of __SIZE_TYPE__ when building for
bare-metal.

	Arnd
