From: bvanassche@acm.org (Bart Van Assche)
Date: Mon, 04 Feb 2013 12:33:13 +0100
Subject: sg_is_chain() call in coh901318_lli_fill_sg()
Message-ID: <510F9C79.4090108@acm.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I'm trying to understand how coh901318_lli_fill_sg() works by studying 
the source code of that function. In that function I found the following 
code:

	for_each_sg(sgl, sg, nents, i) {
		if (sg_is_chain(sg)) {
			[ ... ]

Can anyone explain me why that construct makes sense ? As far as I can 
see in lib/scatterlist.c sg_next() ensures that the for_each_sg() skips 
those elements for which sg_is_chain(sg) == true. Does that mean that 
sg_is_chain(sg) always evaluates to false in the above loop ?

Thanks,

Bart.
