From: dv@vollmann.ch (Detlef Vollmann)
Date: Fri, 21 Jan 2011 16:14:18 +0100
Subject: cannot fetch arm git tree
In-Reply-To: <20110121145025.GS13235@n2100.arm.linux.org.uk>
References: <AANLkTikRrewCLGDTU7DjVssjpxz-EFK8AhRScAGPRumg@mail.gmail.com>
	<20110116092315.GA27542@n2100.arm.linux.org.uk>
	<20110116110819.GG6917@pengutronix.de>
	<AANLkTinrZ0GnT71GCueUUpAXM5ckq+LBd0RjA51DMR-a@mail.gmail.com>
	<20110116134248.GD27542@n2100.arm.linux.org.uk>
	<4D398C43.1000306@vollmann.ch>
	<20110121134728.GO14956@pengutronix.de>
	<20110121135725.GR13235@n2100.arm.linux.org.uk>
	<4D3997FE.5030109@vollmann.ch>
	<20110121145025.GS13235@n2100.arm.linux.org.uk>
Message-ID: <4D39A2CA.5030504@vollmann.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/21/11 15:50, Russell King - ARM Linux wrote:
> On Fri, Jan 21, 2011 at 03:28:14PM +0100, Detlef Vollmann wrote:
>> It seems to be an implementation of the git protocol using
>> HTTP as transport.
>> Some info on this is at<http://progit.org/2010/03/04/smart-http.html>.
>
> Setting up Smart HTTP
>
> ...
>     To set it up, it?s best to walk through the instructions on the
>     `git-http-backend` documentation page. Basically, you have to install Git
>     v1.6.6 or higher on a server with an Apache 2.x webserver (it has to be
>     Apache, currently - other CGI servers don?t work, last I checked). Then
>     you add something similar to this to your http.conf file:
>
>   SetEnv GIT_PROJECT_ROOT /var/www/git
>   SetEnv GIT_HTTP_EXPORT_ALL
>   ScriptAlias /git/ /usr/libexec/git-core/git-http-backend/
>
> Great.  Deciding that it will be http://servername.example.com/git/ is
> really damned annoying as that's traditionally where gitweb lives,
> which requires a different script alias.
>
> It seems that due to a lack of coordination between different git
> developers, people running webservers have a choice between providing
> gitweb or this http extension.
Huh?
/git/ is just the example here, you can use any name you want.
E.g. I use /auth/ for authenticated users, and others use /gitmob/
or /gitanon/ for non-authenticated users.
And you can use something like gitsmart, githttp, or whatever...

   Detlef
