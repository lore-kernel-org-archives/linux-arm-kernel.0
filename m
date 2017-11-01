From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Wed, 1 Nov 2017 13:33:35 +0300
Subject: [PATCH] pinctrl: sirf: Use common error handling code in
 sirfsoc_dt_node_to_map()
In-Reply-To: <CAMuHMdXSVXZNW7a-xf_zyCW-j_KVQbRBdrt8q-SNjGChuDU-bw@mail.gmail.com>
References: <80911d4b-d819-335c-106e-70d7672e645b@users.sourceforge.net>
 <CAMuHMdXSVXZNW7a-xf_zyCW-j_KVQbRBdrt8q-SNjGChuDU-bw@mail.gmail.com>
Message-ID: <20171101103335.y5t7id3okn55r6a2@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Really, the of_node_put() is connected to the loop and not the function
so the original code is the right way to do it.  Otherwise if we added
more error handling to the function then normal kernel error handling
wouldn't work naturally.

regards,
dan carpenter
