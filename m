From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 30 Aug 2013 13:35:33 +0200
Subject: [PATCH RFC 1/2] PM / Hibernate: use name_to_dev_t to parse resume
In-Reply-To: <20130826174050.16429.7419@capellas-linux>
References: <1377114413-8521-1-git-send-email-sebastian.capella@linaro.org>
 <1377114413-8521-2-git-send-email-sebastian.capella@linaro.org>
 <20130825153811.GA4795@amd.pavel.ucw.cz>
 <20130826174050.16429.7419@capellas-linux>
Message-ID: <20130830113533.GA7226@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2013-08-26 10:40:50, Sebastian Capella wrote:
> Apologies for my previous top post reply...
> 
> Quoting Pavel Machek (2013-08-25 08:38:11)
> > Is the allocation actually neccessary? At the very least this should
> > test for NULL...
> 
> 
> Thanks Pavel!  I'll add the check for NULL.
> 
> name_to_dev_t expects a non-const name, but the buffer passed in
> is const.  I also am removing the '\n' if found at the end of the
> string which would violate the const.

Fix name_to_dev_t, then. No need to do memory allocation just to work
around const.

[You can also take a look why it is const in the first place. I don't
think it needs to be.]

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
