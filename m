From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 23 May 2017 21:52:39 +0200
Subject: CHIPPro NAND issue with 4.12 rc1
In-Reply-To: <63aca137397dc3700a34993205c8cfba@www.akkea.ca>
References: <399ea126f3b18071fbe46bfc9787df6b@www.akkea.ca>
 <20170520171418.4e8a47e0@bbrezillon>
 <6f3cefa6c54776f82160ed8954f4d0d4@www.akkea.ca>
 <20170521074535.4a4ba6dd@bbrezillon>
 <20170522070117.mwk4gm34o7idedye@flea.home>
 <63aca137397dc3700a34993205c8cfba@www.akkea.ca>
Message-ID: <20170523195239.6nsv4ydrt4u7q6ge@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 22, 2017 at 10:32:42AM -0600, Angus Ainslie wrote:
> Hi Maxime
> 
> On 2017-05-22 01:01, Maxime Ripard wrote:
> > 
> > This just made me realise, this is also the time where the clocks are
> > disabled, and we changed our clock implementation in 4.11.
> > 
> > And using the 4.4 DT will keep the old driver...
> > 
> > Did you test in 4.11? If it's also broken, could you try to revert
> > 1f4ce3b6ca79 and 6b48644b1d29 (I'm not sure it's going to be a trivial
> > revert, but in that order it should work).
> > 
> 
> Thanks reverting those two allow the kernel to boot and mount the NAND.

Ok, good.

If you unrevert those patches, and add clk_ignore_unused to the kernel
command line, is it still broken?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170523/a4d8412e/attachment.sig>
