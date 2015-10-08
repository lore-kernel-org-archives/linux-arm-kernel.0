From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 8 Oct 2015 18:43:33 +0100
Subject: [PATCH v4] twd: Don't set CLOCK_EVT_FEAT_C3STOP unconditionally
In-Reply-To: <5616AA2D.2070101@free.fr>
References: <56123BD0.8010005@sigmadesigns.com>
 <56124035.6080107@sigmadesigns.com>
 <CACRpkdbWRU3UH6aJnqdcuzdh_-sE7ryhs0vBTUbbRDcJ7PWXLw@mail.gmail.com>
 <561247DF.1000308@sigmadesigns.com>
 <20151005103539.GC19064@leverpostej>
 <5612649C.5020401@sigmadesigns.com>
 <20151008171616.GG7275@leverpostej> <5616AA2D.2070101@free.fr>
Message-ID: <20151008174333.GI32532@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 08, 2015 at 07:38:53PM +0200, Mason wrote:
> On 08/10/2015 19:16, Mark Rutland wrote:
> > Otherwise this looks ok. If you can respin with the above wording, and
> > s/twd-never-stops/always-on/ in the patch, you can add:
> > 
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> Wouldn't you feel like going all-in and Signing-off? ;-)

Then I'd reject it, because it would be wrong.

Documentation/SubmittingPatches:

12) When to use Acked-by: and Cc:
---------------------------------

The Signed-off-by: tag indicates that the signer was involved in the
development of the patch, or that he/she was in the patch's delivery path.

If a person was not directly involved in the preparation or handling of a
patch but wishes to signify and record their approval of it then they can
ask to have an Acked-by: line added to the patch's changelog.

Acked-by: is often used by the maintainer of the affected code when that
maintainer neither contributed to nor forwarded the patch.

Acked-by: is not as formal as Signed-off-by:.  It is a record that the acker
has at least reviewed the patch and has indicated acceptance.  Hence patch
mergers will sometimes manually convert an acker's "yep, looks good to me"
into an Acked-by: (but note that it is usually better to ask for an
explicit ack).

Acked-by: does not necessarily indicate acknowledgement of the entire patch.
For example, if a patch affects multiple subsystems and has an Acked-by: from
one subsystem maintainer then this usually indicates acknowledgement of just
the part which affects that maintainer's code.  Judgement should be used here.
When in doubt people should refer to the original discussion in the mailing
list archives.


-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
