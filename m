From: sebastian.capella@linaro.org (Sebastian Capella)
Date: Mon, 26 Aug 2013 10:40:50 -0700
Subject: [PATCH RFC 1/2] PM / Hibernate: use name_to_dev_t to parse resume
In-Reply-To: <20130825153811.GA4795@amd.pavel.ucw.cz>
References: <1377114413-8521-1-git-send-email-sebastian.capella@linaro.org>
 <1377114413-8521-2-git-send-email-sebastian.capella@linaro.org>
 <20130825153811.GA4795@amd.pavel.ucw.cz>
Message-ID: <20130826174050.16429.7419@capellas-linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Apologies for my previous top post reply...

Quoting Pavel Machek (2013-08-25 08:38:11)
> Is the allocation actually neccessary? At the very least this should
> test for NULL...


Thanks Pavel!  I'll add the check for NULL.

name_to_dev_t expects a non-const name, but the buffer passed in
is const.  I also am removing the '\n' if found at the end of the
string which would violate the const.

Thanks!

Sebastian
