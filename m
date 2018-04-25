From: broonie@kernel.org (Mark Brown)
Date: Wed, 25 Apr 2018 11:31:36 +0100
Subject: [PATCH v2 2/2] regulator: add QCOM RPMh regulator driver
In-Reply-To: <20a8f736-2687-f14f-eaa1-2b2c06eed629@codeaurora.org>
References: <cover.1523673467.git.collinsd@codeaurora.org>
 <4b45f41996ea3344340e44fab2dc9e487572e209.1523673467.git.collinsd@codeaurora.org>
 <CAD=FV=XKYCDtF93RtYi+dokR2BcT-z6Ex3UjgJ0ia_kF=847eA@mail.gmail.com>
 <4e3353fe-ebb5-46bb-aa58-49ad04c4d9db@codeaurora.org>
 <CAD=FV=W28_exRv+H0MJvPnHWGEeUG=SMKr=UqEKpBzkH44Fzmg@mail.gmail.com>
 <132ab845-52d6-6192-4d8c-5a9c95410688@codeaurora.org>
 <20180424174507.GI22073@sirena.org.uk>
 <20a8f736-2687-f14f-eaa1-2b2c06eed629@codeaurora.org>
Message-ID: <20180425103136.GB24769@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2018 at 02:09:47PM -0700, David Collins wrote:
> On 04/24/2018 10:45 AM, Mark Brown wrote:

> > I think that's probably only OK if we have a specific error code for the
> > regulator being limited in this way otherwise our error handling for I/O
> > problems involves us trying to reconfigure supplies which seems like it
> > would be risky.  

> Would you be ok with -EAGAIN being used for this purpose?

Using -EAGAIN for "I can't ever read the configuration from this
regulator" doesn't seem right - it's not like any number of retries
will ever manage to read the value back.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180425/2373cdee/attachment.sig>
