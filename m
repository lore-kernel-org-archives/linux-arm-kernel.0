From: sebastian.capella@linaro.org (Sebastian Capella)
Date: Wed, 29 Jan 2014 10:29:56 -0800
Subject: [PATCH v3 1/2] init/do_mounts.c: ignore final \n in name_to_dev_t
In-Reply-To: <20140128205830.14275.80319@capellas-linux>
References: <1380834638-24035-1-git-send-email-sebastian.capella@linaro.org>
 <1380834638-24035-2-git-send-email-sebastian.capella@linaro.org>
 <20131003141523.8b60ab988799af7e2b2c338b@linux-foundation.org>
 <20131003214246.24540.99218@capellas-linux>
 <20131003234735.19051.84583@capellas-linux>
 <20131010175010.17870.58060@capellas-linux>
 <20131022175414.14753.58063@capellas-linux>
 <20140128185926.5312.36635@capellas-linux>
 <20140128125442.4bac748945b404179deb58ba@linux-foundation.org>
 <20140128205830.14275.80319@capellas-linux>
Message-ID: <20140129182956.14275.72264@capellas-linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

By the way, I do see a call (sysfs_streq) in use for this purpose
other places.  Sorry, I didn't find it while looking at the original
problem.  I'm not sure if this is preferable, but it appears to have
been added specifically for the strings coming through sysfs.

My preference is copying the string and cleaning it up before passing
it to internal functions, even though we incur an allocation.

Thanks,

Sebastian
