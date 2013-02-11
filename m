From: joe@perches.com (Joe Perches)
Date: Mon, 11 Feb 2013 10:30:28 -0800
Subject: [PATCH V2] MAINTAINERS: add keyword "tegra" to Tegra section
In-Reply-To: <1360606760.2028.34.camel@joe-AO722>
References: <1360605099-7088-1-git-send-email-swarren@wwwdotorg.org>
 <1360605395.2028.28.camel@joe-AO722> <511931E8.3080802@wwwdotorg.org>
 <1360605873.2028.30.camel@joe-AO722> <51193476.8020509@wwwdotorg.org>
 <1360606760.2028.34.camel@joe-AO722>
Message-ID: <1360607428.2028.37.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-02-11 at 10:19 -0800, Joe Perches wrote:
> On Mon, 2013-02-11 at 11:12 -0700, Stephen Warren wrote:
> > On 02/11/2013 11:04 AM, Joe Perches wrote:
> > > ./scripts/get_maintainer.pl -f arch/arm/mach-tegra
> > > wouldn't match anything.
> > 
> > That's annoying; it kinda defeats the whole purpose of this patch then.
> > 
> > The way this patch works out with a patch is because the file-names are
> > matched against the keywords since they appear in the patch. A solution
> > to the issue you raise would be to do the same in -f mode, by adding an
> > explicit pass to check the filenames that are found against MAINTAINERS
> > too. Do you have any objection to that?
> 
> Knock yourself out.
> 
> Are there any tegra related files that would not
> have tegra in the path?

To answer my own question:

$ git ls-files | grep -v tegra | xargs grep -Pl "(?i)[^a-z]tegra"
...

Several.  Most are Kconfig and Makefiles.
Most except staging/nvec don't seem to be very important.
