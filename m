From: omycle@gmail.com (Li Haifeng)
Date: Tue, 5 Feb 2013 16:33:43 +0800
Subject: Qestion about page->_count and page reclaim
Message-ID: <CAFNq8R7_tr_MJmPvzvvHDv05jx6+QVPx8n3U_TA5-yB4bE-chg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, all in kernel.

The page->_count is the page frame's usage count. When page is
allocated, the page->_cout will be set 1.

After be allocated from buddy system, the page will be used by
process.  get_page and put_page/put_page_testzero will used in pairs.
is it right?

When the page is reclaimed to buddy system, the page->_count should be
0. However, Because the initialization of page->_count is 1,
get_page() and put_page() is called in pairs, I coufused how
page->_count will be 0?

Thanks.
